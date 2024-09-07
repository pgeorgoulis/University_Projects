import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class HRImpl extends UnicastRemoteObject implements HRInterface{

    public RoomManager manager = new RoomManager();
    private HashMap <String, List<CallbackInterface>> callbackLists;

    public HRImpl() throws RemoteException{
        super();
        int i;
        for(i=0; i<40; i++){
            Room tempRoom = new Room("A", "Single Room", 75);
            manager.getRoomsA().add(tempRoom);
        }
        for(i=0; i<35; i++){
            Room tempRoom = new Room("B", "Double Room", 110);
            manager.getRoomsB().add(tempRoom);
        }
        for(i=0; i<25; i++){
            Room tempRoom = new Room("C", "Twin Room", 120);
            manager.getRoomsC().add(tempRoom);
        }
        for(i=0; i<30; i++){
            Room tempRoom = new Room("D", "Triple Room", 150);
            manager.getRoomsD().add(tempRoom);
        }
        for(i=0; i<20; i++){
            Room tempRoom = new Room("E", "Quad Room", 200);
            manager.getRoomsE().add(tempRoom);
        }

        callbackLists = new HashMap<>();
        callbackLists.put("A", new ArrayList<>());
        callbackLists.put("B", new ArrayList<>());
        callbackLists.put("C", new ArrayList<>());
        callbackLists.put("D", new ArrayList<>());
        callbackLists.put("E", new ArrayList<>());
    }

    @Override
    public String list() throws RemoteException {
        return manager.listRooms();
    }

    @Override
    public String book(String name, String type, int number) throws RemoteException {
        return manager.makeReservation(type, number, name);
    }

    @Override
    public String guests() throws RemoteException {
        return manager.getGuestList();
    }

    @Override
    public String cancel(String name, String type, int number) throws RemoteException {
        notifyCallbacks(type);
        return manager.RemoveReservation(type, number, name);
    }

    @Override
    public void registerCallback(String roomType, CallbackInterface callback) throws RemoteException {
        List<CallbackInterface> list = this.callbackLists.get(roomType);
        if (list != null) {
            list.add(callback);
        }
    }

    @Override
    public void unregisterCallback(String roomType, CallbackInterface callback) throws RemoteException {
        List<CallbackInterface> list = callbackLists.get(roomType);
        if (list != null) {
            list.remove(callback);
        }
    }
    
    private void notifyCallbacks(String roomType) throws RemoteException {
        List<CallbackInterface> list = callbackLists.get(roomType);

        if (list != null) {
            for (CallbackInterface callback : list) {
                callback.notifyUser(roomType);
            }
        }
    }


}

