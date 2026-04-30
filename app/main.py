from fastapi import FastAPI, Response
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time

app = FastAPI(title="Caliman", version="0.1.0")

REQUEST_COUNT = Counter(
    "caliman_http_requests_total",
    "Total HTTP requests",
    ["method", "endpoint", "status"]
)

REQUEST_LATENCY = Histogram(
    "caliman_http_request_duration_seconds",
    "HTTP request latency",
    ["endpoint"]
)


@app.get("/")
def root():
    start = time.time()
    REQUEST_COUNT.labels(method="GET", endpoint="/", status="200").inc()
    REQUEST_LATENCY.labels(endpoint="/").observe(time.time() - start)
    return {
        "service": "caliman",
        "status": "running",
        "stack": ["docker", "ansible", "prometheus", "grafana"]
    }


@app.get("/health")
def health():
    REQUEST_COUNT.labels(method="GET", endpoint="/health", status="200").inc()
    return {"status": "ok"}


@app.get("/ready")
def ready():
    REQUEST_COUNT.labels(method="GET", endpoint="/ready", status="200").inc()
    return {"status": "ready"}


@app.get("/metrics")
def metrics():
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)
