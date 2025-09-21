use cardano/transaction.{OutputReference, Transaction}
use vodka_extra_signatories.{key_signed}
use aiken/crypto.{VerificationKeyHash}

pub type VestingDatum {
  /// Owner's credentials
  owner: VerificationKeyHash,
  /// Beneficiary's credentials
  beneficiary: VerificationKeyHash,
}

validator vesting {
  spend(
    datum_opt: Option<VestingDatum>,
    _redeemer: Data,
    _input: OutputReference,
    tx: Transaction,
  ) {
    expect Some(datum) = datum_opt
    or {
      key_signed(tx.extra_signatories, datum.owner),
      key_signed(tx.extra_signatories, datum.beneficiary),
    }
  }

  else(_) {
    fail
  }
}