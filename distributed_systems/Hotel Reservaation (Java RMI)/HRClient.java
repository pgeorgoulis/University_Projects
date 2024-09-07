import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class HRClient {
    public static void main(String[] args){
        String exitValue = "";  //The string that is returned from every HTImpl function

        try{
            //User gives 2 or 5 arguments
            if(args.length != 2 && args.length !=5){
                displayMenu();
            }

            String choice = args[0];
            String hostname = args[1];
            HRInterface stub = (HRInterface) Naming.lookup(hostname);

            switch(choice){
                case "list":
                    exitValue = stub.list();
                    System.out.println(exitValue);
                    break;
                case "book":
                    String name = args[4];
                    String type = args[2];
                    int number = Integer.parseInt(args[3]);

                    boolean validType = isTypeValid(type);
                    if (! validType){
                        System.out.println("Error: Room type "+type+" does not exist");
                        return;
                    }

                    exitValue = stub.book(name, type, number);
                    System.out.println(exitValue);
                    //TODO return checks should be with ints, not strings
                    if(exitValue.contains("available") || exitValue.contains("empty")){
                        try(Scanner scanner = new Scanner(System.in)){                      
                            //all return messages where the rooms are booked contain these two words. 
                            //Add the users to the waiting list if they want to.

                            //If there is only a specific number of rooms available, ask the user if he wants to reserve them
                            if(exitValue.contains("Warning:")){

                                    //This means the user got the message "Warning: There are only "+ freeRooms+ " type " +type+" rooms available";
                                    System.out.println("\nWould you like to reserve these rooms? (yes/no) ");
                                    String response = scanner.nextLine();

                                    if(response.equalsIgnoreCase("yes")){
                                        //isolate the freerooms var from the string
                                        Pattern pattern = Pattern.compile("only (\\d+) type " + type + " rooms available");
                                        Matcher matcher = pattern.matcher(exitValue);
                                        if (matcher.find()) {
                                            String freeRooms = matcher.group(1);

                                            int newNum = Integer.parseInt(freeRooms);
                                            exitValue = stub.book(name, type, newNum);
                                            System.out.println(exitValue);
                                        }else{
                                            System.out.println("Error: Free rooms string not found");
                                        }
                                    }   
                                
                            }
                            
                            System.out.println("Please enter yes if you would like to be added to our waiting list, enter no to search for other rooms:");

                            String response = scanner.nextLine();
                            if (response.equalsIgnoreCase("yes")) {
                                ClientCallback callback = new ClientCallback();
                                stub.registerCallback(type, callback);
                                System.out.println("You were successfully added to the waiting list. You will be notified if any of type "+type +" reservations are canceled");
                                System.out.println("\nWaiting...");
                            }
                        }
                        
                    }
                    break;
                case "guests":
                    exitValue = stub.guests();
                    System.out.println(exitValue);
                    break;
                case "cancel": 
                    String cancelName = args[4];
                    String cancelType = args[2];
                    int cancelNumber = Integer.parseInt(args[3]);

                    boolean validCancelType = isTypeValid(cancelType);
                    if (! validCancelType){
                        System.out.println("Error: Room type "+cancelType+" does not exist");
                        return;
                    }

                    exitValue = stub.cancel(cancelName, cancelType, cancelNumber);
                    System.out.println(exitValue);
                    break;
                default: 
                    displayMenu();

            }
        }catch (RemoteException e){
            System.err.println("Remote Exception\n" + e.toString());
        }catch (NotBoundException e){
            System.err.println("NotBoundException\n" + e.toString());
        }
        catch (Exception e){
            System.err.println("Exception:\n" + e.toString());
        }
    }

    public static void displayMenu(){
        System.err.println("Error: These are the available options");
        System.err.println("java HRClient list <hostname>");
        System.err.println("java HRClient book <hostname> <type> <number> <name>");
        System.err.println("java HRClient guests <hostname>");
        System.err.println("java HRClient cancel <hostname> <type> <number> <name>");
        System.exit(1);
    }

    public static boolean isTypeValid(String type){
        return "A".equals(type) || "B".equals(type) || "C".equals(type) || "D".equals(type) || "E".equals(type);
    }
}