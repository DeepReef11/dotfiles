{
  mkKeymap = mode: key: action: desc: {
    inherit
      mode
      key
      action
      desc
      ;
  };
  mkKeymap' = mode: key: action: {
    inherit
      mode
      key
      action
      ;
  };
  mkLuaKeymap = mode: key: action: desc: {
    inherit
      mode
      key
      action
      desc
      ;
    lua = true;
  };
  mkLuaKeymap' = mode: key: action: {
    inherit
      mode
      key
      action
      ;
    lua = true;
  };
}
