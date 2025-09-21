use cardano/transaction.{OutputReference, Transaction}
use aiken/crypto.{VerificationKeyHash}
use vodka_extra_signatories.{key_signed}

pub type VestingDatum {
  /// Owner's credentials
  owner: VerificationKeyHash,
  /// Beneficiary's credentials
  beneficiary: VerificationKeyHash,
}

validator vesting {
  spend(
    _datum_opt: Option<VestingDatum>,
    _redeemer: Data,
    _input: OutputReference,
    tx: Transaction,
  ) {
    // Only the owner can unlock
    key_signed(tx.extra_signatories, #"7fedb13d2a85783b14fbdea257773bb5e23ce86b88d8606cdc0d671b")
  }

  else(_) {
    fail
  }
}