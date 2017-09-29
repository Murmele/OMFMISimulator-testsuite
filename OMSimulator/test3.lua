-- status: correct

setLogFile("omsllog.txt")

model = newModel()
setTempDirectory(".")

-- instantiate FMUs
instantiateFMU(model, "../FMUs/me_source1.fmu", "sourceA")
instantiateFMU(model, "../FMUs/me_source1.fmu", "sourceB")
instantiateFMU(model, "../FMUs/me_adder1.fmu", "adder")

-- add connections
addConnection(model, "sourceA.y", "adder.x1")
addConnection(model, "sourceB.y", "adder.x2")

-- set parameter
setReal(model, "sourceA.A", 0.5)
setReal(model, "sourceA.omega", 2.0)

setStopTime(model, 0.0)
--setStopTime(model, 10.0)

initialize(model)
tcur = getCurrentTime(model)
while tcur < 10.0
do
  doSteps(model, 1)
  tcur = getCurrentTime(model)
end
print("sourceA.y at " .. tcur .. ": " .. getReal(model, "sourceA.y"))
print("sourceB.y at " .. tcur .. ": " .. getReal(model, "sourceB.y"))
terminate(model)

unload(model)

-- Result:
-- sourceA.y at 10.1: 0.48791025888348
-- sourceB.y at 10.1: -0.62507064889287
-- info:    Logging information has been saved to "omsllog.txt"
-- endResult
