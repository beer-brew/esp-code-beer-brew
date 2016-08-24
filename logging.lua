Logger = {
}

function Logger:new (o, process_name)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.process_name = process_name
  return o
end

function Logger:_log(priority, msg)
  print("process: '" .. self.process_name .. "' priority: '" .. priority .. "' msg: '" .. msg .. "'")
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
  log = Logger:new()
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

function Trigger:onMessage( filter, callback )

end

function Trigger:onSchedule( schedule, callback )

end

m = Module:new(nil, "test-module")
m:test("asdasd")
