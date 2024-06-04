
# ZKSNARKS and Circom DSL

> A proof-of-concept that how we can generate zero-knowledge proofs with using Circom domain specific language via ZKSNARKS. 

> Check the balance.circom the circuit creation example

## Step 1: Creating Trusted Setup

### 1. Powers of Tau initialization: This establishes the initial parameters.

```cmd	
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
```

### 2. Powers of Tau add contribution: Adds the first contribution.

```cmd	
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First Contribution" -v
```

### 3. Preparing Powers of Tau for Phase 2: Prepares the parameters for Phase 2.

```cmd
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
```

## Step 2: Creating ZKey and Adding Contributions

### 4. Groth16 setup: Creates the first ZKey file.

```cmd
snarkjs groth16 setup balance.r1cs pot12_final.ptau balance_0000.zkey
```
### 5. Add ZKey contribution: Adds the first contribution to the ZKey file.

```cmd
snarkjs zkey contribute balance_0000.zkey balance_0001.zkey --name="First Contribution" -v
```
### 6. Extracting ZKey verification key: Saves the verification key in JSON file.

```cmd
snarkjs zkey export verificationkey balance_0001.zkey verification_key.json
```
## Step 3: Creating and Verifying Evidence

### 7. Creating evidence: Creates an evidence using the witness file.

```cmd
snarkjs groth16 prove balance_0001.zkey witness.wtns proof.json public.json
```
### 8. Proof verification: Verifies using the created proof and verification key.

```cmd
snarkjs groth16 verify verification_key.json public.json proof.json
```
### 9. Saving the verification key: Saves the verification key in JSON file (Already done in Step 6, no need to do it again).

```cmd
snarkjs zkey export verificationkey balance_0001.zkey verification_key.json
```

### 10. Creating evidence: Creates an evidence using the witness file (done in Step 7).

```cmd
snarkjs groth16 prove balance_0001.zkey witness.wtns proof.json public.json
```
### 11. Verify the proof: Verifies using the created proof and verification key (done in Step 8).

```cmd
snarkjs groth16 verify verification_key.json public.json proof.json
```

## Contributing

Contributions to expand or improve the repository are welcome! 

[@denizumutdereli](https://www.linkedin.com/in/denizumutdereli)
```
