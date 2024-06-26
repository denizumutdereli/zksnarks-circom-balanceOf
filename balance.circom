pragma circom 2.0.0;

// Equal booleans
template IsEqual() {
    signal input a;
    signal input b;
    signal output out;

    signal diff;
    diff <== a - b;
    out <== 1 - diff * diff; // if a == b out is 1, if not its 0
}

// lt & gt conditions
template IsLessEqual() {
    signal input a;
    signal input b;
    signal output out;

    signal diff;
    signal comp;
    signal prod;

    diff <== b - a;
    comp <== diff * diff;
    prod <== diff * comp;

    // Küçük eşit kontrolü
    out <== 1 - prod;
}

template RequestProof() {
    // Public inputs
    signal input requestedAmount;
    signal input userBalance;
    signal input validRequest;

    // Private inputs
    signal input requested;

    // Outputs
    signal output isRequestValid;

    // Boolean kontrol bileşenleri
    component isMatchAmount = IsEqual();
    component isSufficientBalance = IsLessEqual();
    component isValidRequest = IsEqual();

    // Conditions
    isMatchAmount.a <== requestedAmount;
    isMatchAmount.b <== requested;

    isSufficientBalance.a <== requestedAmount;
    isSufficientBalance.b <== userBalance;

    isValidRequest.a <== validRequest;
    isValidRequest.b <== 1;

    // Multiplications of the booleans
    signal intermediate;
    intermediate <== isMatchAmount.out * isSufficientBalance.out;
    isRequestValid <== intermediate * isValidRequest.out;
}

component main = RequestProof();
