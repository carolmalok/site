; Small reusable geometry helpers. These are intentionally generic and do not
; copy the original DiffAmpPcell_T28 geometry formulas.

procedure(DAminClamp(value minValue maxValue)
  max(minValue min(maxValue value))
)

procedure(DAminPathPoly(cv layer points width)
  dbConvertPathToPolygon(dbCreatePath(cv layer points width))
)

procedure(DAminLayerOr1(cv layer figList)
  let((out)
    out = dbLayerOr(cv layer figList)
    when(out car(out))
  )
)

procedure(DAminOverlapVia(cv viaName fig1 fig2 xOff yOff cutW cutH spX spY nx ny)
  let((ov)
    ov = car(dbPointArrayAnd(cv list(fig1~>points) list(fig2~>points)))
    when(ov
      dbCreateViaShapeArray(
        cv viaName techGetTechFile(cv)
        xCoord(car(ov)) + xOff
        yCoord(car(ov)) + yOff
        cutW cutH spX spY nx ny
      )
    )
  )
)

procedure(DAminCreatePin(cv name layer ll ur labelPt labelJust)
  let((net rect)
    net = dbCreateNet(cv name)
    rect = dbCreateRect(cv layer list(ll ur))
    dbCreatePin(net rect)
    dbCreateLabel(cv list(layer "text") labelPt name labelJust "R0" "roman" 2.0)
    rect
  )
)
