[< back](../../TABLE_OF_CONTENT.md)

# Architecture Weak Points

Most vulnerabilities in a web application stem from improperly designed application architecture rather than from poorly written methods.

## Insecure Architecture Signals

At a bare minimum a web application include the following **functionalities**:

- UI to write a message,
- API endpoint to receive a message just written and submitted,
- A database table to store a message,
- An API endpoint to retrieve one or more messages (database read),
- UI code to display one or more messages.

The security mechanisms should be abstracted into the application architecture rather than implemented on a case-by-case basis.

## Multilayer Security

Each functionality mentioned above will in principle have some security mechanism.

> Look for a functionality that makes use of few security mechanisms, or requires a significant number of layers (hence likely to have a lower ratio of security mechanism per layer) and prioritize it over the rest.

## Adoption and Reinvention

> Talented software engineers and mathematicians may be able to develop their own hashing algorithm to avoid using open algorithms - but at what cost?
>
> SHA-3 is open-source, developed for nearly 20 years and has received robust resting from National Institute of Standards and Technology (NIST), and contributions from the largest security firms in the US.

Good web application developers understand that it is impossible to be an expert at everything and that he should not reinvent mission-critical functionalities.