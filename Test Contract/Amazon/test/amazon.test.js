var Amazon = artifacts.require('Amazon');

contract('Amazon', function(accounts) {
  const owner = accounts[0];
  const seller = accounts[1];
  const buyer = accounts[2];

  const ether = 1e18;
  const gasPrice = 15000000000;

  const products = [
    {
      name: 'ABC',
      price: '2'
    },
    {
      name: 'XYZ',
      price: '5'
    }
  ];

  const state = { ForSale: 0, Sold: 1, Shipped: 2, Received: 3 };

  const productStructure = ['name', 'sku', 'price', 'state', 'seller', 'buyer'];

  const productDetail = async (fn, account) => {
    const lastAddProduct = await fn({ from: seller });
    let product = lastAddProduct.reduce((arr, cur, i) => {
      arr[productStructure[i]] = cur;
      return arr;
    }, {});
    return product;
  };

  const weiToEther = wei => web3.fromWei(wei, 'ether');

  it('should let seller to add an item', async () => {
    const amazon = await Amazon.deployed();
    await amazon.addItem(...Object.values(products[0]), { from: seller });
    let product = await productDetail(amazon.fetchLast, seller);

    assert.equal(product.seller, seller, 'check addItem method or constructor');
    assert.equal(
      product.state,
      state.ForSale,
      'check addItem method or constructor'
    );
  });

  it('should let buyer to buy an item', async () => {
    const amazon = await Amazon.deployed();
    const extra = 3 * ether;

    products.forEach(async product => {
      await amazon.addItem(...Object.values(product), { from: seller });
    });

    let product = await productDetail(amazon.fetchLast, buyer);

    const sellerBalanceBeforePurchase = await web3.eth
      .getBalance(seller)
      .toString();

    const buyerBalanceBeforePurchase = await web3.eth
      .getBalance(buyer)
      .toString();

    const buyItem = await amazon.buyItem(product.sku.toString(), {
      from: buyer,
      value: product.price.add(extra),
      gasPrice
    });
    const gasUsed = buyItem.receipt.gasUsed;
    const gasCost = gasPrice * gasUsed;

    const sellerBalanceAfterPurchase = await web3.eth
      .getBalance(seller)
      .toString();
    const buyerBalanceAfterPurchase = await web3.eth
      .getBalance(buyer)
      .toString();

    assert.equal(
      weiToEther(sellerBalanceAfterPurchase - sellerBalanceBeforePurchase),
      weiToEther(product.price.toString()),
      'check buyItem method or constructor'
    );

    assert.equal(
      parseFloat(
        weiToEther(
          buyerBalanceBeforePurchase - buyerBalanceAfterPurchase - gasCost
        )
      ).toFixed(2),
      parseFloat(weiToEther(product.price.toString())),
      'check buyItem method or constructor'
    );

    product = await productDetail(amazon.fetchLast, seller);

    assert.equal(product.buyer, buyer, 'check buyItem method or constructor');

    assert.equal(
      product.state,
      state.Sold,
      'check buyItem method or constructor'
    );
  });

  it('should let seller to ship an item', async () => {
    const amazon = await Amazon.deployed();

    products.forEach(async product => {
      await amazon.addItem(...Object.values(product), { from: seller });
    });

    let product = await productDetail(amazon.fetchLast, buyer);

    const buyItem = await amazon.buyItem(product.sku.toString(), {
      from: buyer,
      value: product.price,
      gasPrice
    });

    product = await productDetail(amazon.fetchLast, buyer);

    assert.equal(
      product.state,
      state.Sold,
      'check shipItem method or constructor'
    );

    const shipItem = await amazon.shipItem(product.sku.toString(), {
      from: seller
    });

    product = await productDetail(amazon.fetchLast, seller);

    assert.equal(
      product.state,
      state.Shipped,
      'check shipItem method or constructor'
    );
  });

  it('should let buyer to recieve an item', async () => {
    const amazon = await Amazon.deployed();

    products.forEach(async product => {
      await amazon.addItem(...Object.values(product), { from: seller });
    });

    let product = await productDetail(amazon.fetchLast, buyer);

    const buyItem = await amazon.buyItem(product.sku.toString(), {
      from: buyer,
      value: product.price,
      gasPrice
    });

    const shipItem = await amazon.shipItem(product.sku.toString(), {
      from: seller
    });

    const recieveItem = await amazon.receiveItem(product.sku.toString(), {
      from: buyer
    });

    product = await productDetail(amazon.fetchLast, buyer);

    assert.equal(
      product.state,
      state.Received,
      'check receiveItem method or constructor'
    );
  });
});
