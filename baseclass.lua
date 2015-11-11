local function Base(classname)

  local self = {}

  local classname = classname

  function self.InstanceOf(_classname)
    return _classname == classname
  end

  function self.GetStorageLocation()
    return tostring(self)
  end

  return self

end

return Base
