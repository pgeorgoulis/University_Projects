import java.rmi.Remote;
import java.rmi.RemoteException;

public interface HRInterface extends Remote{

    public String list() throws RemoteException;

    public String book(String name, String type, int number) throws RemoteException;

    public String guests() throws RemoteException;

    public String cancel(String name, String type, int number) throws RemoteException;

    public void registerCallback(String type, CallbackInterface callback) throws RemoteException;

    public void unregisterCallback(String roomType, CallbackInterface callback) throws RemoteException;
}
