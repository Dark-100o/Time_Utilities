;; Time Utilities Contract
;; A smart contract for time-based calculations and scheduling systems
;; Provides utilities for deadline management and time-based operations

;; Define constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-invalid-deadline (err u101))
(define-constant err-deadline-passed (err u102))
(define-constant err-invalid-duration (err u103))
(define-constant err-schedule-not-found (err u104))

;; Data structures
(define-map schedules 
  { creator: principal, schedule-id: uint }
  { 
    deadline: uint,
    duration-blocks: uint,
    created-at: uint,
    description: (string-ascii 256),
    is-active: bool
  })

(define-data-var next-schedule-id uint u1)
(define-data-var total-schedules uint u0)

;; Function 1: Create Schedule
;; Creates a new time-based schedule with deadline and duration
(define-public (create-schedule (duration-blocks uint) (description (string-ascii 256)))
  (let (
    (schedule-id (var-get next-schedule-id))
    (current-block-height burn-block-height)
    (deadline (+ current-block-height duration-blocks))
  )
    (begin
      ;; Validate inputs
      (asserts! (> duration-blocks u0) err-invalid-duration)
      (asserts! (<= (len description) u256) err-invalid-duration)
      
      ;; Create the schedule
      (map-set schedules 
        { creator: tx-sender, schedule-id: schedule-id }
        {
          deadline: deadline,
          duration-blocks: duration-blocks,
          created-at: current-block-height,
          description: description,
          is-active: true
        })
      
      ;; Update counters
      (var-set next-schedule-id (+ schedule-id u1))
      (var-set total-schedules (+ (var-get total-schedules) u1))
      
      ;; Return schedule details
      (ok {
        schedule-id: schedule-id,
        deadline: deadline,
        blocks-remaining: duration-blocks,
        created-at: current-block-height
      }))))

;; Function 2: Check Deadline Status
;; Checks if a deadline has passed and calculates remaining time
(define-read-only (check-deadline-status (creator principal) (schedule-id uint))
  (let (
    (schedule-data (map-get? schedules { creator: creator, schedule-id: schedule-id }))
  )
    (match schedule-data
      schedule
      (let (
        (current-block burn-block-height)
        (deadline (get deadline schedule))
        (is-expired (>= current-block deadline))
        (blocks-remaining (if is-expired u0 (- deadline current-block)))
        (blocks-elapsed (- current-block (get created-at schedule)))
      )
        (ok {
          schedule-id: schedule-id,
          creator: creator,
          deadline: deadline,
          current-block: current-block,
          is-expired: is-expired,
          blocks-remaining: blocks-remaining,
          blocks-elapsed: blocks-elapsed,
          duration-blocks: (get duration-blocks schedule),
          description: (get description schedule),
          is-active: (get is-active schedule),
          progress-percentage: (if (> (get duration-blocks schedule) u0)
                               (/ (* blocks-elapsed u100) (get duration-blocks schedule))
                               u0)
        }))
      err-schedule-not-found)))

;; Read-only helper functions
(define-read-only (get-total-schedules)
  (ok (var-get total-schedules)))

(define-read-only (get-current-block-height)
  (ok burn-block-height))

(define-read-only (calculate-future-block (blocks-ahead uint))
  (ok (+ burn-block-height blocks-ahead)))

;; Get schedule details
(define-read-only (get-schedule (creator principal) (schedule-id uint))
  (match (map-get? schedules { creator: creator, schedule-id: schedule-id })
    schedule (ok schedule)
    err-schedule-not-found))