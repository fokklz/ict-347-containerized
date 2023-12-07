# Kubectl (feat. Minikube)

This directory contains some example kubernetes configurations. The configurations are meant to be used with [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/). 

Minikube is a tool that allows you to run a single node kubernetes cluster on your local machine. The configurations include scripts to simplify the process of deploying and deleting the configurations.

the command used by the scripts is `kubectl` which is the official kubernetes command line tool.

## Contents<!-- omit in toc -->

- [Kubectl (feat. Minikube)](#kubectl-feat-minikube)
  - [Prerequisites](#prerequisites)
  - [Access](#access)
  - [Usage](#usage)
    - [Deploying](#deploying)
    - [Deleting](#deleting)
    - [Backup \& Restore](#backup--restore)
      - [Backup](#backup)
      - [Restore](#restore)


## Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/)

## Access

When deployed you can access the services by using they're port combined with the IP of the minikube cluster. You can get the IP of the minikube cluster by running the following command:

```bash
minikube ip
# Example response: 172.27.28.103
```

Lets say the Service you want to access is running on port `30001`. You can then access it by opening `http://172.27.28.103:30001` in your browser.

Which service is exposed on which port can be found in the `README.md` file of each project. 

## Usage

Enter the directory of the project you want to work with. Each of the **commands below should be run from the project directory.**

### Deploying

To deploy a project, open a terminal in the project directory and run the following command:

```bash
# Unix
./deploy.sh
# Windows
powershell .\deploy.ps1
```

### Deleting

To delete a project, open a terminal in the project directory and run the following command:

```bash
# Unix
./delete.sh
# Windows
powershell .\delete.ps1
```

### Backup & Restore

Since this is my first time working with Kubernetes i skipped creating any automated solution for this. I will have to gather more experience with Kubernetes before i can create a solution for this.

#### Backup

What you can do if you want to backup a namespace is to export all resources in the namespace to a yaml file. You can do this with the following command:

```html
kubectl get all -n <namespace> -o yaml > <namespace>.yaml
```

Ensure to replace `<namespace>` with the name of the namespace you want to export. You can later then use the exported yaml file to import the resources again.

Ensure to also backup important data for a project. You can find all PVC-Claims by running the following command:

```html
kubectl get pv -n <namespace>
kubectl describe pv <pv-name> -n <namespace>
```

Ensure to replace `<pv-name>` with the name of the PV you want to backup received from the previous command.
You can use the Path described under `Source` to find the data you want to backup.


#### Restore

Ensure to place the Data you copied from the PVs into the locations they were before.
You can then restore the resources by running the following command:

```html
kubectl apply -f <namespace>.yaml
```

They should now boot up again. Using the data you placed in the PVs.