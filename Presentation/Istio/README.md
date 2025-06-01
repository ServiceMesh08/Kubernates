# Presentation - Istio Quick Setup

This folder contains the **quick-launch version** of the Istio lab, designed for fast deployment during presentations, exams, or demos.

You will use prebuilt files and scripts to instantly create a working microservice architecture secured with **Istio v1.16.7**, bypassing the manual steps from the full lab.

---

## 🔧 Technologies Used

- **Istio**: v1.16.7  
- **Kubernetes**: v1.22.4  
- **CNI plugin**: Cilium (v0.16.24)

---

## 📁 Folder Contents

| File Name           | Description                                                              |
|---------------------|--------------------------------------------------------------------------|
| `IstioSetup.sh`     | Automates the deployment of all required services and policies           |
| `YamlCreation.yaml` | Contains service definitions and policies (peer auth, authorization)     |
| `Dockerfile`        | Container definition for the app used in this demo                       |
| `app.py`            | Python microservice that simulates traffic and service behavior          |
| `README.md`         | This documentation file                                                  |

---

## 🚀 How to Use

1. Make sure **Istio is installed** and the namespace has `istio-injection=enabled`.  
   You can enable sidecar injection with:

   ```bash
   kubectl label namespace default istio-injection=enabled
2. Then launch the quick setup script:

   ```bash
    chmod +x IstioSetup.sh  
    ./IstioSetup.sh

