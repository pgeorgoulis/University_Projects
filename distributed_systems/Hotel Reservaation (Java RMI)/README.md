
# Hotel Reservation System (Java RMI)

## Overview

This project is a client-server application implemented using **Java RMI** (Remote Method Invocation). The system allows multiple clients to concurrently interact with a hotel reservation system to book, list, and manage room reservations.

The hotel has five types of rooms available:

- **Type A (Single)**: 25 rooms, 60€/night
- **Type B (Double)**: 40 rooms, 80€/night
- **Type C (Twin)**: 20 rooms, 90€/night
- **Type D (Triple)**: 15 rooms, 115€/night
- **Type E (Quad)**: 10 rooms, 140€/night

Each client can:

- List available rooms
- Make reservations for specific room types
- Cancel existing reservations
- View all guest bookings
- Get notified when a room of the desired type becomes available (if added to the notification list)

## Prerequisites

- **Java Development Kit (JDK)** version 8 or later.
- **Java RMI Registry**.

## How to Run the System

### 1. Compile the Code

\`\`\` bash
javac *.java
\`\`\`

### 2. Start the RMI Registry

To enable communication between client and server, you need to start the RMI registry:

\`\`\`bash
rmiregistry
\`\`\`

### 3. Run the Server

The server should be started first to handle incoming client requests.

\`\`\`bash
java HRServer
\`\`\`

### 4. Run the Client

The client can run with the following commands:
