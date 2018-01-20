-- Initializes GUnit and loads the files in the proper order.

GUnit = {}
GUnit.Asserts = {}
GUnit.Colors = {}
GUnit.Generators = {}
GUnit.Tests = {}
GUnit.version = "v0.1.0"
GUnit.travis = false

local enableTests = true

if (SERVER and enableTests) then
  include("gunit/main/global/sv_stringsplit.lua")
  include("gunit/main/testengine/sv_colors.lua")
  include("gunit/main/testengine/sv_runner.lua")
  include("gunit/main/testengine/sv_pending.lua")
  include("gunit/main/testengine/sv_result.lua")
  include("gunit/main/testengine/sv_test.lua")
  include("gunit/main/testengine/sv_load.lua")
  include("gunit/main/testengine/sv_assertclass.lua")
  include("gunit/main/generators/sv_stringgen.lua")
  include("gunit/main/generators/sv_fakeentity.lua")
  include("gunit/main/generators/sv_fakeplayer.lua")
  include("gunit/main/generators/sv_ctakedamageinfo.lua")
  include("gunit/test/sv_testinit.lua")
  hook.Run("GUnitReady")
end

hook.Add("Initialize", "__GUnitTestInitialize", function()
  hook.Run("GUnitReady")

  --Run Travis
  local exp = string.Explode( ".", GetHostName()  )

  if exp[1] == "travis" then
    GUnit.travis = true
    timer.Simple(5,function ()
      print("Running Travis: " .. exp[2])
      RunConsoleCommand( "test-only", exp[2] )
      print("Exiting Server in 10 seconds")

      timer.Simple(10,function ()
        RunConsoleCommand( "_restart" )
      end)
    end)
  end
end)
