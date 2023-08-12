

const iconsList = [
{
    icon: `<CarOutline height="0.8em" width="0.8em" />`,
    descricao: "Automotivo",
},
{
    icon: `<IoAirplaneOutline height="0.8em" width="0.8em" />`,
    descricao: "Viagens",
},
{
    icon: `<BusOutline height="0.8em" width="0.8em" />`,
    descricao: "Transporte",
}, 
{
    icon: `<LaptopOutline height="0.8em" width="0.8em" />`,
    descricao: "Tecnologia",
}, 
{
    icon: `<FlaskOutline height="0.8em" width="0.8em" />`,
    descricao: "Laboratorial",
}, 
{
    icon: `<PawOutline height="0.8em" width="0.8em" />`,
    descricao: "Pet",
}, 
{
    icon: `<PiPottedPlantThin height="0.8em" width="0.8em" />`,
    descricao: "Jardinagem",
},
{
    icon: `<BookOutline height="0.8em" width="0.8em" />`,
    descricao: "Educação",
}, 
{
    icon: `<KeyOutline height="0.8em" width="0.8em" />`,
    descricao: "Chaveiro",
}, 
{
    icon: `<ConstructOutline height="0.8em" width="0.8em" />`,
    descricao: "Serviços Domésticos",
},
{
    icon: `<RestaurantOutline height="0.8em" width="0.8em" />`,
    descricao: "Alimentação",
},
{
    icon: `<FitnessOutline height="0.8em" width="0.8em" />`,
    descricao: "Saúde",
}, 
{
    icon: `<LiaBabyCarriageSolid height="0.8em" width="0.8em" />`,
    descricao: "Cuidados especiais",
},
{
    icon: `<GiHandSaw height="0.8em" width="0.8em" />`,
    descricao: "Marcenaria",
},
];



export default iconsList.sort((a, b) => a.descricao.localeCompare(b.descricao));