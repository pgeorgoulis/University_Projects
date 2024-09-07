import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class HRServer extends HRImpl {

    public HRServer() throws RemoteException{
        super();
    }

    public static void main(String[] args){
        try{
            HRImpl impl = new HRImpl();
            //HTInterface stub = (HTInterface) UnicastRemoteObject.exportObject(impl, 0);
            Registry registry = LocateRegistry.getRegistry();

            registry.bind("hostname", impl);
            System.out.println("Running...");

        }catch (Exception e){
            System.err.println("Server exception:\n" + e.toString());
            e.printStackTrace();
        }
    }
}
