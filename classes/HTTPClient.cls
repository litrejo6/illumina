public class HTTPClient {
    private http http;
    private httpRequest client;
    
    public  HTTPClient(string strEndPoint, String strMethod){
        client= new HttpRequest(); 
        client.setTimeout(120000);
        client.setEndpoint(strEndPoint);
        client.setMethod(strMethod);
    }
    
    public  HttpResponse getResponse(){
        http= new Http();
        return http.send(client);
    }
}