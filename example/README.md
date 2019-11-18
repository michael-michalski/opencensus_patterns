# Example

1. Start Jaeger

    ```shell
    docker run --network host -d -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 -p5775:5775/udp -p6831:6831/udp -p6832:6832/udp \
    -p5778:5778 -p16686:16686 -p14268:14268 -p9411:9411 jaegertracing/all-in-one:latest
    ```

2. Run example

    ```shell
    iex -S mix
    > Example.top("hello", "world")
    ```

3. Check the dashboard

    ```shell
    Check http://localhost:16686
    ```
