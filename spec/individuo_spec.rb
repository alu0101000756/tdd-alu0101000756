require "spec_helper"

RSpec.describe Individuo do
  before :each do
      @a = []
      @a[0] = Individuo.new("Eugenio", false, true, 73, 1.82, 25, 1)
      @a[1] = Individuo.new("Tatiana", false, true, 52, 1.69, 20, 0)
      @a[2] = Individuo.new("Daniela", false, true, 73, 1.67, 22, 0)
      @a[3] = Individuo.new("Ghaz", false, false, 72, 1.77, 22, 1)
      @a[4] = Individuo.new("Greg", false, true, 140, 1.81, 22, 1)
      @a[5] = Individuo.new("Jesus", false, true, 100, 1.81, 25, 1)
      @lst = Lista.new
      @lst.push(@a)
  end
  it "has a version number" do
    expect(Individuo::VERSION).not_to be nil
  end
  
    context "Individuo" do
        it "Tiene los atributos necesarios" do
            expect(@a[0]).to have_attributes(:nombre => "Eugenio", :paciente => false, :t_obesidad => true, :peso => 73, :altura => 1.82, :edad => 25, :sexo => 1)
        end
        it "Es de la clase correcta" do
            expect(@a[0].class).to eq(Individuo)
        end
        it "Su super clase es la correcta" do
            expect(@a[0].class.superclass).to eq(IMC)
        end
        it "El tipo es el correcto" do
            expect(@a[0].is_a?(Individuo)).to eq(true)
        end
        it "categoriza segun imc" do
            puts @lst.head.value
            expect(@lst.pop_head.cat_peso).to eq("Saludable")
            expect(@lst.pop_head.cat_peso).to eq("Bajo peso")
            expect(@lst.pop_head.cat_peso).to eq("Sobrepeso")
            expect(@lst.pop_head.cat_peso).to eq("Sin datos recogidos")
            expect(@lst.pop_tail.cat_peso).to eq("Obesidad")
            expect(@lst.pop_tail.cat_peso).to eq("Obesidad Extrema")
        end
        it "tiene un metodo to_s" do
            puts @lst
            expect(@a[0].to_s).to eq("Eugenio pesa 73 kilos , mide 1.82 metros, tiene 25 años y es un hombre")
        end
        it "tiene un metodo para saber el peso ideal" do
            expect(@a[0].peso_ideal).to eq(74)
        end
        it "puede calcular TMB" do
           expect(@a[0].tmb).to eq(730 + 1137.5 - 125 + 5 )
           expect(@a[0].efecto_termogeno).to eq(@a[0].tmb * 0.1)
           expect(@a[0].gasto_actividad_fisica("ligera")).to eq(@a[0].tmb * 0.12)
           puts @a[0].gasto_energetico_total("ligera")
           expect(@a[0].gasto_energetico_total("ligera")).to eq(@a[0].tmb + @a[0].efecto_termogeno + @a[0].gasto_actividad_fisica("ligera"))
        end
    end
    context "comparable" do
        it "puede compararse" do
            expect(@a[1] > @a[0]).to eq(false)
            expect(@a[1] == @a[0]).to eq(false)
            expect(@a[1] < @a[0]).to eq(true)
        end
    end
end