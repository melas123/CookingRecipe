volumes = [
  { id: 1, name: 'ml'   },
  { id: 2, name: 'cl'   },
  { id: 3, name: 'litre'}
]
weights = [
  { id: 1, name: 'g'     },
  { id: 2, name: 'Kg'    }
]
measures = [
  { id: 1, name: 'Mass'   },
  { id: 2, name: 'Volume' },
  { id: 3, name: 'None'   }
]
@cooking.constant("volumes" : volumes, "weights": weights, "measures": measures)
