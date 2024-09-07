public class Reservation {
    private String roomType;

    public String getRoomType() {
        return roomType;
    }

    public int getNumberOfRooms() {
        return numberOfRooms;
    }

    public String getName() {
        return name;
    }

    public int getCost() {
        return cost;
    }

    private int numberOfRooms;
    private String name;
    private int cost;

    /*array list of reservations, get the type of the room from the Room object, get the price also from there
    * */

    public Reservation(String roomType, int numberOfRooms, String name, int cost){
        this.roomType = roomType;
        this.numberOfRooms = numberOfRooms;
        this.name = name;
        this.cost = cost;
    }

    @Override
    public String toString() {
        return "User: "+this.name+"\t\t Number of rooms: "+this.numberOfRooms+"\t\t Type of rooms:"+
                this.roomType+"\t\t Total cost of reservation: "+this.cost;
    }
}
