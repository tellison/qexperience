# Before you can use the jobs API, you need to set up an access token.
# Log in to the Quantum Experience. Under "Account", generate a personal 
# access token.
#
# Either:
# 1) Replace "PUT_YOUR_API_TOKEN_HERE" below with the quoted token string.
# Uncomment the APItoken variable, and you will be ready to go.
# 2) Export your API token as an environment variable called "QISKIT_API_TOKEN".

import os

#APItoken = "PUT_YOUR_API_TOKEN_HERE"

config = {
  "url": 'https://quantumexperience.ng.bluemix.net/api'
}

if 'APItoken' not in locals():
   if 'QISKIT_API_TOKEN' in os.environ:
      APItoken = os.environ['QISKIT_API_TOKEN']
   else:
      raise Exception("Please set up your access token. See Qconfig.py.")

