import java.rmi.Remote;
import java.rmi.RemoteException;

public interface CallbackInterface extends Remote{
    void notifyUser(String roomType) throws RemoteException;
}
