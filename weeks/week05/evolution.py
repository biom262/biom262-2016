#!/usr/bin/env python
from random import choice, random

ALPHABET = 'abcdefghijklmnopqrstuvwxyz '

def initialize(parent, num):
    """Returns num random sequences the length of parent."""
    return [[choice(ALPHABET) for i in range(len(parent))] for seq in range(num)]

def score(seq, target):
    """Returns number of differences between seq and target."""
    return sum(map(int, [a != b for a, b in zip(seq, target)]))

def select(population, scores):
    """Returns best sequence and score from population."""
    scored = zip(scores, population)
    scored.sort()
    return scored[0]

def breed(parent, num, mutation_rate):
    """Returns num copies of parent with mutation_rate changes per letter."""
    result = []
    length = len(parent)
    for seq in range(num):
        curr = parent[:]
        for pos in range(length):
            if random() <= mutation_rate: curr[pos] = choice(ALPHABET)
        result.append(curr)
    return result

def evolve(target, num=10000, mutation_rate=0.01, generation=0):
    """Evolves random sequences towards seed, using ALPHABET."""
    population = initialize(target, num)
    while 1:
        scores = [score(seq, target) for seq in population]
        best_score, best_seq = select(population, scores)
        print generation, '\t', best_score, '\t', ''.join(best_seq)
        if best_score == 0: break
        population = breed(best_seq, num, mutation_rate)
        generation += 1

evolve('nothing in biology makes sense except in the light of evolution')
~                                                                           
