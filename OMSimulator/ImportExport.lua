-- name: test2
-- status: correct

version = getVersion()
-- print(version)

setTempDirectory(".")
model = newModel()

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

setStartTime(model, 0.0)
setStopTime(model, 10.0)
setTolerance(model, 1e-5)

exportXML(model, "ImportExport.xml")

model2 = loadModel("ImportExport.xml")
describe(model2)

unload(model)
unload(model2)

-- Result:
-- # FMU instances
-- sourceA
--   - FMI 2.0 ME (solver: euler)
--   - path: ../FMUs/me_source1.fmu
--   - GUID: {a31d622a-f33e-4172-9c76-96665d8d1b60}
--   - tool: OpenModelica Compiler OMCompiler v1.12.0-dev.395+gdeeabde
--   - input interface:
--   - output interface:
--     - output y
--   - parameters:
--     - parameter A
--     - parameter omega
-- sourceB
--   - FMI 2.0 ME (solver: euler)
--   - path: ../FMUs/me_source1.fmu
--   - GUID: {a31d622a-f33e-4172-9c76-96665d8d1b60}
--   - tool: OpenModelica Compiler OMCompiler v1.12.0-dev.395+gdeeabde
--   - input interface:
--   - output interface:
--     - output y
--   - parameters:
--     - parameter A
--     - parameter omega
-- adder
--   - FMI 2.0 ME (solver: euler)
--   - path: ../FMUs/me_adder1.fmu
--   - GUID: {bd121558-6b16-4944-819d-dd5fc0b9b8ea}
--   - tool: OpenModelica Compiler OMCompiler v1.12.0-dev.395+gdeeabde
--   - input interface:
--     - input x1
--     - input x2
--   - output interface:
--     - output y
--   - parameters:
--
-- # Simulation settings
--   - start time: 0
--   - stop time: 10
--   - tolerance: 1e-05
--   - communication interval: 0.1
--   - result file: ImportExport_res.mat
--
-- # Composite structure
-- ## Initialization
-- sourceA.y -> adder.x1
-- sourceB.y -> adder.x2
--
-- ## Simulation
-- sourceA.y -> adder.x1
-- sourceB.y -> adder.x2
--
-- endResult
