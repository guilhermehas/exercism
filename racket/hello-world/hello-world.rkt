#lang racket

(provide hello)
(require racket/format)

(define (hello . lst)
  (match lst
    ((list) "Hello, World!")
    ((list el) (~a "Hello, " el "!"))))

