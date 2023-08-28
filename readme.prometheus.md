# metricbeat prometheus remote write benchmarking

A k8s cluster on kind with metricbeat in remote write configuration with self monitoring enabled.
And instructions to install and configure the prometheus benchmark tool from VictoriaMetrics.

## instructions

Create a k8s cluster

```bash
./up.sh
```

Put your elasticsearch credential into a secret

```bash
kubectl create secret generic elastic-secret \                      
--from-literal=elastic_endpoint='your elasticsearch endpoint' \
--from-literal=elastic_password='your password' \
--from-literal=elastic_user='your user'
```

Start a Metricbeat with prometheus remote write configuration

```bash
kubectl apply -f metricbeat.yaml
```

Install VictoriaMetrics benchamrking tool

```bash
git clone https://github.com/VictoriaMetrics/prometheus-benchmark
```

Update the `prometheus-benchmark/chart/values.yaml`:

`writeURL: "http://metricbeat-svc.default.svc.cluster.local:9201/write"`
`targetsCount: 20000`
`writeReplicaMem: "8Gi"`

Install the prometheus benchmark in your cluster

```bash
cd prometheus-benchmark
make install
```

You can update the `prometheus-benchmark/chart/values.yaml` and re-execute the `make install` to apply the new values.

`writeConcurrency` looks like the number of shards of prometheus.remote_write.queue_config.
