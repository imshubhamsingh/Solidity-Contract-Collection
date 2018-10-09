var SimpleBank = artifacts.require('./SimpleBank.sol');

contract('SimpleBank', function(accounts) {
  const owner = accounts[0];
  const alice = accounts[1];
  const bob = accounts[2];
  const ether = 1e18;
  const rate = 0.01 * ether;

  const etherToWei = ether => ether.toString();

  it('should put 1000 tokens in the first and second account', async () => {
    const bank = await SimpleBank.deployed({
      from: owner,
      value: etherToWei(10 * ether)
    });

    await bank.enroll({ from: alice });
    await bank.enroll({ from: bob });

    const aliceBalance = await bank.balance({ from: alice });
    assert.equal(
      aliceBalance,
      1000,
      'enroll balance is incorrect, check balance method or constructor'
    );

    const bobBalance = await bank.balance({ from: bob });
    assert.equal(
      bobBalance,
      1000,
      'enroll balance is incorrect, check balance method or constructor'
    );

    const ownerBalance = await bank.balance({ from: owner });
    assert.equal(
      ownerBalance,
      0,
      'only enrolled users should have balance, check balance method or constructor'
    );
  });

  it('should deposit correct amount', async () => {
    const bank = await SimpleBank.new({
      from: owner,
      value: etherToWei(10 * ether)
    });
    const deposit = 500;

    await bank.enroll({ from: alice });
    await bank.enroll({ from: bob });

    await bank.deposit(deposit, { from: alice, value: etherToWei(500 * rate) });
    const balance = await bank.balance({ from: alice });
    assert.equal(
      (1000 + deposit).toString(),
      balance,
      'deposit amount incorrect, check deposit method'
    );

    const expectedEventResult = {
      accountAddress: alice,
      amount: deposit
    };

    const LogDepositMade = await bank.allEvents();
    const log = await new Promise(function(resolve, reject) {
      LogDepositMade.watch(function(error, log) {
        resolve(log);
      });
    });

    const logAccountAddress = log.args.accountAddress;
    const logAmount = log.args.amount;
    assert.equal(
      expectedEventResult.accountAddress,
      logAccountAddress,
      'LogDepositMade event accountAddress property not emmitted, check deposit method'
    );

    assert.equal(
      expectedEventResult.amount.toString(),
      logAmount.toString(),
      'LogDepositMade event amount property not emmitted, check deposit method'
    );
  });

  it('should withdraw correct amount', async () => {
    const bank = await SimpleBank.new({
      from: owner,
      value: etherToWei(10 * ether)
    });
    const deposit = 200;

    await bank.enroll({ from: alice });

    await bank.withdraw(deposit.toString(), { from: alice });

    const balance = await bank.balance({ from: alice });

    assert.equal(
      (1000 - deposit).toString(),
      balance.toString(),
      'withdraw amount incorrect, check withdraw method'
    );
  });

  it('should allow to check the current balance ', async () => {
    const bank = await SimpleBank.new({
      from: owner,
      value: etherToWei(10 * ether)
    });

    const deposit = 1000;
    const withdraw = 500;

    await bank.enroll({ from: alice });

    await bank.deposit(deposit, {
      from: alice,
      value: etherToWei(deposit * rate)
    });
    await bank.withdraw(withdraw, { from: alice });

    const aliceBalance = await bank.balance({ from: alice });

    assert.equal(
      aliceBalance.toString(),
      (1000 + deposit - withdraw).toString(),
      'current balance is incorrect, check balance method or constructor'
    );
  });
});
