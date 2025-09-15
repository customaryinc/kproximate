# Taint Support Implementation

This document describes the taint support added to kproximate.

## Changes Made

### 1. Configuration
- Added `KpNodeTaints` field to `config.KproximateConfig`
- Added environment variable support: `kpNodeTaints`

### 2. Kubernetes Client
- Added `TaintKpNode` method to `Kubernetes` interface
- Implemented taint application logic with conflict retry
- Added mock implementation for testing

### 3. Scaler Logic
- Added `renderNodeTaints` function similar to `renderNodeLabels`
- Integrated taint application in node provisioning workflow
- Added template support for dynamic values

### 4. Helm Chart
- Added `kpNodeTaints` to values.yaml with documentation
- Added environment variable to configmap template

### 5. Documentation
- Updated README with taint usage examples
- Created example configuration with taints

## Usage

Configure taints in your values.yaml:

```yaml
kproximate:
  config:
    kpNodeTaints: "node-type:worker:NoSchedule,dedicated:{{ .TargetHost }}:PreferNoSchedule"
```

## Taint Format

Taints use the format: `key:value:effect`

- **key**: Taint key (e.g., "node-type")
- **value**: Taint value, supports templates (e.g., "worker" or "{{ .TargetHost }}")
- **effect**: One of NoSchedule, PreferNoSchedule, NoExecute

Multiple taints are comma-separated.

## Template Variables

Currently supported template variable:
- `{{ .TargetHost }}`: Name of the Proxmox host where the node is provisioned

## Testing

The implementation includes:
- Unit test for taint parsing logic
- Validation script to verify template rendering
- Example configurations demonstrating usage

## Integration

Taints are applied automatically during node provisioning, after the node joins the cluster but before it's marked as ready for scheduling.
