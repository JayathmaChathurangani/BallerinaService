
import ballerina.net.http;
import ballerina.lang.system;




@http:configuration {basePath:"/version"}
service<http> helloWorld {

    @http:GET{}
    @http:Path {value:"/maven3"}
    resource sayHello (message m) {

        system:println("Hello");

        http:ClientConnector mavenVer = create http:ClientConnector("https://api.npms.io/v2/package");

        message response = {};
        message req = {};
        system:println("Hello1");
        response = mavenVer.get("/eslint-config", req);

        system:println("over");
        reply response;

    }
}