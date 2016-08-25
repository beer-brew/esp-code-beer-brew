Logger = {
}

function Logger:new (o, source_config)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.source = source_config or {}
  self.source.chip_id = node.chipid()
  return o
end

function Logger:_log(priority, msg)
  event = {
    source = self.source,
    priority = priority,
    message = msg
  }
  print(cjson.encode(event))
  -- mqtt(event)
end

function Logger:debug(msg)
  self:_log("debug", msg)
end

function Logger:info(msg)
  self:_log("info", msg)
end

function Logger:notice(msg)
  self:_log("notice", msg)
end

function Logger:warn(msg)
  self:_log("warn", msg)
end

function Logger:crit(msg)
  self:_log("crit", msg)
end

function Logger:emerg(msg)
  self:_log("emerg", msg)
end

Module = {
  log = Logger:new(nil, { process = "test-module" } )
}

function Module:new (o, name)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.name = name
  self.log.process_name = name
  return o
end

function Module:test(blah)
  self.log:debug(blah)
  self.log:info(blah)
  self.log:notice(blah)
  self.log:warn(blah)
  self.log:crit(blah)
  self.log:emerg(blah)
end

Trigger = {}

-- filter: function that returns a boolean. true to exec callback
function Trigger:onMessage( filter, callback )

end

-- can schedule be a cron type string? exec callback when match
function Trigger:onSchedule( schedule, callback )

end

m = Module:new(nil, "test-module")
m:test("asdasd")
