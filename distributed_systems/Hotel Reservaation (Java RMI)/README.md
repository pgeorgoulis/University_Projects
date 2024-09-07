
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

## Project Structure

The system consists of the following main components:

- **HRServer**: The server managing the hotel room availability and client requests.
- **HRClient**: The client application that allows users to interact with the server.
- **HRInterface**: The remote interface defining the methods that clients can invoke on the server.
- **HRImpl**: The implementation of the remote interface on the server side.

## Prerequisites

- **Java Development Kit (JDK)** version 8 or later.
- **Java RMI Registry**.

Ensure that both server and client machines have a working Java environment.

## How to Run the System

### 1. Compile the Code

\`\`\`bash
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

#### Help Command

Running the client without any parameters will print usage instructions.

\`\`\`bash
java HRClient
\`\`\`

#### List Available Rooms

To list the number of available rooms of each type:

\`\`\`bash
java HRClient list <hostname>
\`\`\`

Example:

\`\`\`bash
java HRClient list localhost
\`\`\`

#### Book Rooms

To book rooms for a client:

\`\`\`bash
java HRClient book <hostname> <type> <number> <name>
\`\`\`

- \`<type>\`: The type of room (A, B, C, D, E).
- \`<number>\`: The number of rooms.
- \`<name>\`: The name of the client making the reservation.

Example:

\`\`\`bash
java HRClient book localhost A 2 JohnDoe
\`\`\`

#### View Guest List

To view the list of all clients and their reservations:

\`\`\`bash
java HRClient guests <hostname>
\`\`\`

Example:

\`\`\`bash
java HRClient guests localhost
\`\`\`

#### Cancel Reservation

To cancel a room reservation for a specific client:

\`\`\`bash
java HRClient cancel <hostname> <type> <number> <name>
\`\`\`

Example:

\`\`\`bash
java HRClient cancel localhost A 1 JohnDoe
\`\`\`

### 5. Notification for Room Availability

If a booking fails due to unavailability, the client can opt to be notified when rooms of the requested type become available. The client will be added to a notification list and will receive a message if a room is canceled.

#### Notification Workflow:

1. During a failed booking attempt, the system will ask if the client wants to be notified.
2. Upon cancellation by another client, the system will notify all waiting clients.

## Example Runs

Here are some examples of how the system might behave:

- **List Available Rooms**:

  \`\`\`bash
  java HRClient list localhost
  
  20 rooms of type A - 60€/night
  35 rooms of type B - 80€/night
  10 rooms of type C - 90€/night
  8 rooms of type D - 115€/night
  5 rooms of type E - 140€/night
  \`\`\`

- **Booking Rooms**:

  \`\`\`bash
  java HRClient book localhost A 2 Alice
  
  Booking successful! Total cost: 120€
  \`\`\`

- **Cancel Reservation**:

  \`\`\`bash
  java HRClient cancel localhost A 1 Alice
  
  Cancellation successful! Alice now has 1 room of type A.
  \`\`\`

- **Guests List**:

  \`\`\`bash
  java HRClient guests localhost
  
  Alice - 1 room(s) of type A, total cost: 60€
  \`\`\`

## Error Handling and Notifications

- If a booking request fails due to lack of availability, the client will be informed.
- Clients will be asked whether they want to be notified if rooms become available.
- Cancellations trigger notifications to waiting clients, printing a message on their terminal.

## Features

### Core Features

- **Concurrent Client Access**: Multiple clients can connect and book rooms simultaneously.
- **Room Listing**: Real-time listing of available rooms.
- **Room Booking**: Booking rooms for different types, with success/failure responses.
- **Reservation Cancellation**: Clients can cancel reservations and free up rooms.
- **Guest List Management**: Clients can view the list of all current hotel guests and their bookings.

### Advanced Features (Part B)

- **Waitlist and Notifications**: Clients can be added to a waitlist and will be notified when rooms become available.
- **Real-time Notifications**: Upon cancellation, waiting clients are instantly notified.

## Deliverables

- Source code files for all components.
- Documentation (this README).
- Sample outputs of various client operations.
