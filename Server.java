import io.vertx.core.Vertx;
import function.Handler;

public class Server  {
  public static void main(String[] args) throws Exception {
    function.Handler handler = new function.Handler();

      Vertx.vertx().createHttpServer().requestHandler(req -> {
        req.bodyHandler(body -> {
          
          req.response()
            .putHeader("content-type", "text/plain")
            .end(handler.Handle(body.toString()));
        });
      }).listen(8081);
  }
}
