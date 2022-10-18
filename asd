import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;

public class Main {
    public static void main(String[] args) {





    }

    class DATE {
        private int day;
        private int month;
        private int year;

        public DATE(int day, int month, int year) {
            this.day = day;
            this.month = month;
            this.year = year;
        }

        public int getDay() {
            return day;
        }

        public void setDay(int day) {
            this.day = day;
        }

        public int getMonth() {
            return month;
        }

        public void setMonth(int month) {
            this.month = month;
        }

        public int getYear() {
            return year;
        }

        public void setYear(int year) {
            this.year = year;
        }

        public int subtract(DATE newDate) {
            int oldDateDays = this.year * 365;
            int newDateDays = newDate.getYear() * 365;
            for (int i = 1; i <= this.month; i++) {
                if (i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10 || i == 12) {oldDateDays += 31;}
                else if (i == 2) {oldDateDays += 28;}
                else {oldDateDays += 30;}
            }
            oldDateDays += this.day;

            for (int i = 1; i <= newDate.getMonth(); i++) {
                if (i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10 || i == 12) {newDateDays += 31;}
                else if (i == 2) {newDateDays += 28;}
                else {newDateDays += 30;}
            }
            newDateDays += newDate.getDay();
            return oldDateDays - newDateDays;

        }

    }

    class Product {
        private String name;
        private DATE DATE;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public DATE getDATE() {
            return DATE;
        }

        public void setDATE(DATE DATE) {
            this.DATE = DATE;
        }

        public double getBasePrice() {
            return basePrice;
        }

        public void setBasePrice(double basePrice) {
            this.basePrice = basePrice;
        }

        private double basePrice;

        public Product(String name, DATE DATE, double basePrice) {
            this.name = name;
            this.DATE = DATE;
            this.basePrice = basePrice;
            while (this.basePrice * 100 % 5 != 0) {this.basePrice += 0.01;}
        }



    }


    LocalDate ld = LocalDate.now();
    DATE currentDate = new DATE(ld.getYear(), ld.getMonthValue(), ld.getYear());

    public double totalPrice(List<Product> laden) {
        double sum = 0;
        for (Product p: laden) {
            if (currentDate.subtract(p.getDATE()) <= 10) {sum += p.getBasePrice();}
            else if (currentDate.subtract(p.getDATE()) <= 20) {sum += (p.getBasePrice() * 90 / 100);}
            else {sum += (p.getBasePrice() * 80 / 100);}
        }
        return sum;
    }

    public List<Product> accuratePrices (List<Product> laden) {
        List<Product> newList = new ArrayList<>();
        for (Product p: laden) {
            if (currentDate.subtract(p.getDATE()) <= 10) { newList.add(p);}
            else if (currentDate.subtract(p.getDATE()) <= 20) {newList.add(new Product(p.getName(), p.getDATE(), p.getBasePrice() * 90 / 100));}
            else {newList.add(new Product(p.getName(), p.getDATE(), p.getBasePrice() * 80 / 100));}
        }
        return newList;
    }

    public List<Product> over9000 (List<Product> laden) {
        List<Product> newList = accuratePrices(laden);
        int n = laden.size();
        int i = 0;
        while (i <= n) {
            if (laden.get(i).getBasePrice() < 100) {
                laden.remove(i);
                n -= 1;
            } else {i++;}
        }
        return newList;
    }

    public List<Product> sortList (List<Product> laden) {
        List<Double> newList = new ArrayList<Double>();
        for (Product p: accuratePrices(laden)) {
            newList.add(p.getBasePrice());
        }
        Collections.sort(newList);
        List<Product> copy = new ArrayList<>();
        copy.addAll(laden);
        List<Product> sortedList = new ArrayList<>();
        int j = 0;
        while (!copy.isEmpty()) {
            if (newList.get(0) == copy.get(j).getBasePrice()) {
                sortedList.add(copy.get(j));
                newList.remove(0);
                copy.remove(j);
                j = 0;
            } else {j++;}

        }
        return sortedList;
    }

    public Product mostExpensiveProduct (List<Product> laden) {return sortList(laden).get(laden.size());}

    public Product cheapestProduct (List<Product> laden) {return sortList(laden).get(0);}

}
