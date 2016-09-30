#lang racket/base

(require
  rackunit
  data/collection
  racket/match)

(test-case
 "Empty matches"
 (check-equal? (match '(1 2 3) [(sequence) #t] [_ #f]) #f)
 (check-equal? (match '() [(sequence) #t] [_ #f]) #t))

(test-case
 "Finite matches"
 (check-equal? (match #(1 2 3 4) [(sequence a b c d) c]) 3)
 (check-equal? (match #(1 2 3 4) [(sequence 2 b c d) c] [_ #f]) #f)
 (check-equal? (match #(1 2 3 4) [(sequence 1 2 3 4) #t]) #t)
 (check-equal? (match #(1 2 3 4) [(sequence 1 2 3) #t] [_ #f]) #f))

(test-case
 "Lazy tail matches"
 (check-equal? (match #(1 2 3 4) [(sequence a b ...) a]) 1)
 (check-equal? (match #(1 2 3 4) [(sequence a b ...) (last b)]) 4)
 (check-equal? (match #() [(sequence a b ...) a] [_ #f]) #f))

(test-case
 "Strict internal matches"
 (check-equal? (match #(1 2 3 4) [(sequence a b ... c) b]) '(2 3)))
