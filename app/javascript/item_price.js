function price() {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById('add-tax-price');
    let tax = inputValue * 0.1;
    addTaxDom.innerHTML = Math.floor(tax);
    const total = document.getElementById('profit');
    total.innerHTML = Math.floor(inputValue - tax);
 });
};
window.addEventListener('load', price)