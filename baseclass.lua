local function Base()

  local self = {}
  self.classname = "Base"

  function self.InstanceOf(_classname)
    return self.classname == _classname
  end

  function self.GetStorageLocation()
    return tostring(self)
  end

  return self

end

return Base
