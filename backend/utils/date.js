async function getCurrentDateTime() {
  const currentDate = new Date();
  // console.log(currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds())
  return currentDate;
}
module.exports = getCurrentDateTime;
