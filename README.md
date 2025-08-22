# Time Utilities

## Project Description

The Time Utilities smart contract is a comprehensive time-based calculation and scheduling system built on the Stacks blockchain using Clarity. This contract provides essential utilities for creating time-bound schedules, tracking deadlines, and performing block-height-based time calculations. It enables developers and users to create schedules with specific durations, monitor deadline status, and calculate time-related metrics in a decentralized environment.

The contract leverages Stacks' block-height mechanism to provide reliable time tracking, making it suitable for applications requiring precise timing mechanisms such as project management, automated task scheduling, and time-locked operations.

## Project Vision

Our vision is to create a foundational time management infrastructure on the Stacks blockchain that empowers developers to build sophisticated time-aware decentralized applications. We aim to:

- **Democratize Time Management**: Provide accessible time utilities that any developer can integrate into their dApps
- **Enable Decentralized Scheduling**: Create trustless scheduling systems that operate without central authorities
- **Foster Innovation**: Serve as building blocks for more complex time-based DeFi protocols, governance systems, and automated workflows
- **Ensure Reliability**: Deliver precise, blockchain-native time tracking that applications can depend on
- **Promote Interoperability**: Establish standard patterns for time-based operations that other contracts can easily integrate

## Future Scope

### Phase 1: Enhanced Time Features
- **Recurring Schedules**: Implement support for repeating schedules (daily, weekly, monthly)
- **Time Zones**: Add support for different time zone calculations
- **Advanced Notifications**: Create event-based notifications for deadline approaches

### Phase 2: Advanced Scheduling
- **Multi-User Scheduling**: Enable collaborative scheduling between multiple parties
- **Conditional Scheduling**: Implement schedules that activate based on specific conditions
- **Schedule Dependencies**: Create schedules that depend on completion of other schedules
- **Priority Systems**: Add priority levels and scheduling queues

### Phase 3: Integration & Automation
- **DeFi Integration**: Connect with DeFi protocols for time-locked staking and vesting
- **Oracle Integration**: Incorporate real-world time data through oracles
- **Cross-Contract Scheduling**: Enable scheduling across multiple smart contracts
- **Automated Execution**: Implement automatic execution of scheduled tasks

### Phase 4: Governance & Analytics
- **Governance Integration**: Enable time-based voting and proposal systems
- **Analytics Dashboard**: Provide comprehensive scheduling analytics and insights
- **Performance Metrics**: Track and optimize scheduling efficiency
- **Community Features**: Allow public scheduling and community-managed calendars

### Long-term Vision
- **Enterprise Solutions**: Scale to support enterprise-level scheduling needs
- **Mobile SDK**: Develop mobile SDKs for easy integration
- **AI-Powered Scheduling**: Integrate AI for intelligent schedule optimization
- **Cross-Chain Compatibility**: Expand to other blockchain networks

## Contract Functions

### Core Functions

#### 1. `create-schedule`
Creates a new time-based schedule with specified duration and description.

**Parameters:**
- `duration-blocks` (uint): Number of blocks until deadline
- `description` (string-ascii 256): Description of the schedule

**Returns:**
- Schedule ID, deadline block, blocks remaining, and creation block

#### 2. `check-deadline-status`
Checks the status of a specific schedule and calculates time-related metrics.

**Parameters:**
- `creator` (principal): Address of the schedule creator
- `schedule-id` (uint): Unique identifier of the schedule

**Returns:**
- Comprehensive status including expiration status, remaining time, progress percentage

### Read-Only Functions

- `get-total-schedules`: Returns total number of created schedules
- `get-current-block-height`: Returns current block height
- `calculate-future-block`: Calculates future block height
- `get-schedule`: Retrieves complete schedule details


## Getting Started

### Prerequisites
- Stacks wallet (Hiro Wallet, Xverse, etc.)
- STX tokens for transaction fees
- Basic understanding of Clarity smart contracts

### Usage Examples

```clarity
;; Create a schedule that expires in 1000 blocks
(contract-call? .time-utilities create-schedule u1000 "Project Deadline")

;; Check deadline status
(contract-call? .time-utilities check-deadline-status 'SP1ABC...XYZ u1)
```

## Contract Address

**Testnet Address:** `ST275GE4Q110ZSS4FA2X24ZKXNAH3H8R1JVYEDE4J.timeutilities`

### Screenshots

<img width="1904" height="861" alt="image" src="https://github.com/user-attachments/assets/7acb4825-dc6f-4478-b462-2a55433f853b" />


*Built with ❤️ on Stacks blockchain | Contributing to the decentralized future*
