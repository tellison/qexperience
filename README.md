# Docker file for IBM Q tutorials

This Dockerfile makes it easy to run the Jupyter notebooks containing examples for the IBM Q system.

To get started, you must have an account at https://www.research.ibm.com/ibm-q/ . These are free to create.

To run the examples export your API key, obtained from your IBM Q account settings, as an environment variable, and run docker like this.

```
#!/bin/bash

export IBMQ_API_TOKEN="my_long_api_uuid_key_goes_here"

docker run -e IBMQ_API_TOKEN -p 8888:8888 tellison/qiskit-tutorial
```

The name `tellison/qiskit-tutorial` is the pre-built image version I have uploaded to docker hub.  You should replace that with the name of the docker image you created locally if you prefer.

When started up the console will show you a URL where you can connect to the notebooks, for example:

```
$ docker run -e IBMQ_API_TOKEN -p 8888:8888 tellison/qiskit-tutorial
[I 12:18:02.627 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[W 12:18:04.533 NotebookApp] WARNING: The notebook server is listening on all IP addresses and not using encryption. This is not recommended.
[I 12:18:04.574 NotebookApp] JupyterLab beta preview extension loaded from /ibmq/anaconda/lib/python3.6/site-packages/jupyterlab
[I 12:18:04.574 NotebookApp] JupyterLab application directory is /ibmq/anaconda/share/jupyter/lab
[I 12:18:04.578 NotebookApp] Serving notebooks from local directory: /ibmq/qiskit-tutorial-master
[I 12:18:04.578 NotebookApp] 0 active kernels
[I 12:18:04.578 NotebookApp] The Jupyter Notebook is running at:
[I 12:18:04.578 NotebookApp] http://[all ip addresses on your system]:8888/?token=1d0ed3328ada938770af9977b178e37bda3ffa310b16a587
[I 12:18:04.578 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 12:18:04.578 NotebookApp] 
    
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=1d0ed3328ada938770af9977b178e37bda3ffa310b16a587
```

When you connect a browser to the URL given you should select the file called `index.ipynb` and the notebook examples are linked from there.
