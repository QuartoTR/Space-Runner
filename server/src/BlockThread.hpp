#ifndef BLOCKTHREAD_HPP
#define BLOCKTHREAD_HPP

#include <mutex>

#include "Blockchain.hpp"


#define BATCH_SIZE 25000


class BlockThread : public Blockchain {

public:

	BlockThread() : Blockchain() {}

protected:

	virtual void mine_last(const bool & debug = false);

private:

	bool found;
	unsigned short int num_cpus;

	void mine_inst(std::mutex *, const unsigned short int &, const bool &);

};

#endif