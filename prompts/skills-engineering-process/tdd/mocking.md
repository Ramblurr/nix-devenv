# When to Mock

Mock only at **system boundaries**. A system boundary is where the code reaches a resource or service with a lifecycle outside the behavior under test.

## Prefer real behavior

Use real components or in-memory implementations for code you control. Introduce a test double only when the real boundary would make the test slow, unsafe, unavailable, or nondeterministic.

## Understand the boundary

Before replacing a boundary, identify:

- Its complete contract and data shape
- Its meaningful side effects
- Its failure modes
- Which of those behaviors the test depends on

A partial double hides assumptions and creates false confidence.

## Design a narrow seam

Inject an operation-specific boundary interface instead of constructing the dependency inside the behavior under test. Prefer one explicit operation per boundary capability over a generic request function that forces conditional logic into the double.

Each test double should represent one contract and return one known shape.

## Assert outcomes

Drive the public interface and assert its observable result. Calls made to a double may help diagnose a failure, but they are not the behavior under test.

## Mocking gate

Before adding a mock or test double, answer:

1. What system boundary does it replace?
2. Why is the real boundary unsuitable for this test?
3. What complete contract, side effects, and failures must the double preserve?
4. Which observable outcome will the test assert?

Mocking is justified when all four answers are explicit.
