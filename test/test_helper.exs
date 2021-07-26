Application.load(:swag_souls)

for app <- Application.spec(:swag_souls, :applications) do
  Application.ensure_all_started(app)
end

ExUnit.start()
