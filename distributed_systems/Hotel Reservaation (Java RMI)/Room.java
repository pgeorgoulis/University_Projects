public class Room {
    private final String type;
    private String fullName;
    private final int price;
    private boolean reserved;

    public Room(String type, String fullName, int price){
        this.type = type;
        this.fullName = fullName;
        this.price = price;
        this.reserved = false;
    }

    public String getType() {
        return type;
    }

    public int getPrice() {
        return price;
    }

    public boolean isReserved(){
        return reserved;
    }

    public void setReserved(boolean reserved) {
        this.reserved = reserved;
    }

    public String getFullName(){
        return fullName;
    }
}
