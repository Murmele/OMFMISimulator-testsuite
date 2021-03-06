-- status: correct

setLogFile("omsllog.txt")

setTempDirectory(".")
model = loadModel('ConnectedFmu.xml')

--setReal(model, "sourceA.A", 0.5)
--setReal(model, "sourceA.omega", 2.0)

initialize(model)
simulate(model)
tcur = getCurrentTime(model)
print("adder1.y at " .. tcur .. ": " .. getReal(model, "adder1.y"))
print("adder2.y at " .. tcur .. ": " .. getReal(model, "adder2.y"))

terminate(model)
unload(model)

-- Result:
-- adder1.y at 2.1: 0.54162379186909
-- adder2.y at 2.1: 1.564940364302
-- info:    Logging information has been saved to "omsllog.txt"
-- endResult
