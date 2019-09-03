import subprocess
ps = subprocess.Popen("ps | wc -l", shell=True, stdout=subprocess.PIPE)
numProcesses = int(ps.stdout.read()) - 1
print("You are running " + str(numProcesses) + " processes")
