import java.util.ArrayList;
import java.util.HashMap;

public class RoomManager {
    private ArrayList<Reservation> reservations = new ArrayList<>();
    
    private final ArrayList<Room> roomsA = new ArrayList<>();
    private final ArrayList<Room> roomsB = new ArrayList<>();
    private final ArrayList<Room> roomsC = new ArrayList<>();
    private final ArrayList<Room> roomsD = new ArrayList<>();
    private final ArrayList<Room> roomsE = new ArrayList<>();
    private HashMap<String, ArrayList<Room>> roomMap = new HashMap<>();

    public RoomManager(){
        this.roomMap.put("A", roomsA);
        this.roomMap.put("B", roomsB);
        this.roomMap.put("C", roomsC);
        this.roomMap.put("D", roomsD);        
        this.roomMap.put("E", roomsE);
    }
    public ArrayList<Room> getRoomsA() {
        return roomsA;
    }

    public ArrayList<Room> getRoomsB() {
        return roomsB;
    }

    public ArrayList<Room> getRoomsC() {
        return roomsC;
    }
    public ArrayList<Room> getRoomsD() {
        return roomsD;
    }
    public ArrayList<Room> getRoomsE() {
        return roomsE;
    }


    public String listRooms(){
        String message ="";
        int emptyRooms = 0;
        int price;
        String type;
        String fullname;
        
        //find the empty rooms
        for (String key : roomMap.keySet()) {
            roomMap.get(key).get(0).getPrice();
            price = roomMap.get(key).get(0).getPrice();
            type = roomMap.get(key).get(0).getType();
            fullname = roomMap.get(key).get(0).getFullName();
            emptyRooms = calcEmptyRooms(type);

            message += emptyRooms+"\ttype "+type+" rooms ("+fullname+")\t-\tprice: "+price+ "\tper night"+"\n";
        }
        return message;
    }

    public String makeReservation(String type, int number, String name){

        if(number < 0){
            return "Error: Number of rooms is not valid";
        }
        
        int freeRooms = calcEmptyRooms(type);
        if(freeRooms >= number){
            //Get the index and book the first <number> rooms that are found. 
            //If no rooms are found return an error message 

            for(int j=0; j<number;j++){
                int freeRoomIndex = getRoomIndex(roomMap.get(type));
                if(freeRoomIndex != -1){
                    roomMap.get(type).get(freeRoomIndex).setReserved(true);
                }else{
                    return "Error: no empty rooms were found";
                }
            }
            
            //Make a new Reservation and add it to the list
            int reservationCost = roomMap.get(type).get(0).getPrice() * number;
            Reservation reservation = new Reservation(type, number, name, reservationCost);
            reservations.add(reservation);

            return "Success: Your total cost is " + reservationCost;

        }else if(freeRooms < number && freeRooms > 0){
            String str = "Warning: There are only "+ freeRooms+ " type " +type+" rooms available";
            return str;
        }else {
            return "Error: There aren't any available type " + type + " rooms.";
        }
    }

    public String getGuestList(){
        String guestList = "";

        if (reservations.isEmpty()){
            return "0 reservations were found";
        }
        for(Reservation res : reservations){
            guestList += res.toString() + "\n";
        }

        return guestList;
    }

    public String RemoveReservation(String type, int number, String name){
        String message ="";

        for(Reservation res : reservations){
            if(res.getName().equals(name)){

                int numOfRooms = res.getNumberOfRooms();
                
                /*if the input is wrong*/
                if (number > numOfRooms){
                    return "Error: User "+res.getName()+" has only reserved "+res.getNumberOfRooms()+" rooms";
                
                }else if(numOfRooms == number){     /*if the user wants to remove all the rooms*/
                    
                    reservations.remove(res);
                    clearRooms(roomMap.get(type), number);
                    
                    return "Reservation: \n\nName: "+name+"\tNumber of rooms:"+res.getNumberOfRooms()+"\tTotal cost: "+res.getCost()+"\n\nwas removed successfully";
                
                }else{                              /*if the user wants to remove specific rooms*/
                    
                    clearRooms(roomMap.get(type), number);
                    
                    /*The new number of rooms: (The original rooms) - (the canceled)*/
                    int editedRooms = numOfRooms - number;
                    int cost = res.getCost() / res.getNumberOfRooms();
                    
                    //Make the new reservation
                    Reservation editedReservation = editReservation(editedRooms, type, name, cost);
                    reservations.remove(res);
                    reservations.add(editedReservation);
                    message = "Reservation edited successfully\nThe new reservation is:\n";
                    message += editedReservation.toString();
                    return message;
                }
            }
        }
        
        /* If the function does not return by the end of the for it means the user was not found.*/
        return "Error: User " + name+" has not made any reservations.";
    }


    /*Gets an array list of rooms and the number of rooms you wish to cancel the reservation on*/
    /*Clears the reservations on the rooms.*/
    private void clearRooms(ArrayList<Room> roomList, int numOfDeletedRooms){
        int counter =0;
        for(Room r : roomList) {
            if (r.isReserved()) {
                r.setReserved(false);
                counter++;
            }
            if (counter == numOfDeletedRooms) {
                break;
            }
        }
    }

    /*Gets the edited number of rooms, the type and the name as input*/
    private Reservation editReservation(int numOfRooms, String type, String name, int costPerRoom){
        int cost = numOfRooms * costPerRoom;
        Reservation res = new Reservation(type, numOfRooms, name, cost);
        return res;

    }
    
    
    private int calcEmptyRooms(String type){
        //Returns the number of empty rooms in the asked arraylist.
        //Wich arraylist will be searched is determined by the room type variable
        int bookedRooms =0;

        for(Room room : roomMap.get(type)){
            if(room.isReserved()){
                bookedRooms += 1;
            }
        }

        return roomMap.get(type).size() - bookedRooms;
    }



    private int getRoomIndex(ArrayList<Room> list){
        /*Get as input the arraylist of a specific room type. Return the index of the  available room*/
        int i;
        for (i=0; i<list.size(); i++) {
            if( ! list.get(i).isReserved()){
                return i;
            }
        }
        return -1;
    }

}
