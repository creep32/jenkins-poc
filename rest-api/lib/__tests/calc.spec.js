const calc = require('../calc')

describe('sum function', () => {
  test('simple sum', () => {
    expect(calc.sum(1, 2)).toBe(3)
  })

  test('simple sum with negative number', () => {
    expect(calc.sum(-10, 6)).toBe(-4)
  })
})

describe('minus function', () => {
  test('simple minus', () => {
    expect(calc.minus(10, 1)).toBe(9)
  })

  test('simple minus with negative number', () => {
    expect(calc.minus(-10, 1)).toBe(-11)
  })
})
