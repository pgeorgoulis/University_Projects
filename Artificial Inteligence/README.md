# Elevator Evacuation Problem
##Overview

This project tackles the problem of evacuating a multi-story building using an elevator. The goal is to move all occupants to the ground floor efficiently, adhering to specific constraints.
Building Layout

    Floors:
        1st floor: 12 occupants
        2nd floor: 3 occupants
        3rd floor: 7 occupants
        4th floor: 8 occupants
    Elevator:
        Capacity: 10 people
        Initial position: Ground floor
        Movement: Up if not full and occupants are present; Down if full or no more occupants are waiting above.

## Tasks

    DFS Solution:
        Implement DFS to solve the evacuation.
        Track and present the search results.

    BFS and Parallel Path Monitoring:
        Add BFS as an alternative search method.
        Implement parallel path monitoring for efficiency.

    Heuristic Search:
        Introduce a heuristic to optimize the evacuation process.

## Implementation

    Model: Define building, floors, and elevator constraints.
    Algorithms: Implement DFS, BFS, and a heuristic search.
    Testing: Compare algorithms and assess performance.

## Usage

    Run DFS: Simulate evacuation and analyze results.
    Switch to BFS: Evaluate BFS performance.
    Apply Heuristic: Test and improve evacuation efficiency.


## Licensed under the MIT License. See LICENSE for details.