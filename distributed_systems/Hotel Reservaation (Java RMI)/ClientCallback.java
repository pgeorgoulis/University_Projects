import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class ClientCallback extends UnicastRemoteObject implements CallbackInterface{
    public ClientCallback() throws RemoteException{
        super();
    }

    @Override
    public void notifyUser(String roomType) throws RemoteException {
        System.out.println("Notification: Room for type " + roomType + " is now available.");
    }
}
